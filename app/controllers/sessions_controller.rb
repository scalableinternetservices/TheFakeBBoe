require 'rake'

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def seed
    # parameters
    num_users = 500
    num_user_profiles = 3
    num_user_subs = 5
    num_tags = 10
    num_memes = num_users * num_user_profiles

    num_messages = 20
    template = {
      created_at: Time.now,
      updated_at: Time.now,
    }
    # Create one first user
    first_user = User.create!(username: 'abc', password: 'password', email: 'abc@gmail.com')
    profile1 = Profile.create!(user: first_user, name: 'EdgyMemelord12', age: 120)
    conversation = Conversation.create!(name: "my-very-long-convo")

    ApplicationRecord.transaction do

      
      puts "adding users..."
      users = []
      pw_hash = BCrypt::Password.create('password')
      for counter in 1..num_users do
        username = "user#{counter}"
        user = {
          username: username,
          password_digest: pw_hash,
          email: "#{username}@example.com",
        }
        users.append(template.merge(user))
      end
      users = User.insert_all!(users, returning: [:id, :username]).to_a

      puts "adding messages"
      messages = []
      for u in users do
        for i in 1..num_messages do
          message = {
            user_id: u['id'],
            conversation_id: conversation.id,
            content: "blahblahblah",
            username: u['username']
          }
          messages.append(template.merge(message))
        end
      end
      messages = Message.insert_all!(messages)

      puts "adding profiles..."
      profiles = []
      for u in users do
        for profile_count in 1..num_user_profiles do
          profile = {
            user_id: u['id'],
            name: "Rick_#{u['id']}_#{profile_count}",
            age: 21,
            occupation: 'job',
            location: 'place',
            bio: 'hi',
          }
          profiles.append(template.merge(profile))
        end
      end
      profiles = Profile.insert_all!(profiles, returning: [:id]).to_a

      puts "adding subscriptions..."
      subscribes = []
      for i in 0..(num_users - 1) do
        for j in 0..(num_user_subs - 1) do
          # subscribe to $num_user_subs profiles belonging to unique users
          sub = {
            user_id: users[i]['id'],
            profile_id: profiles[((i + 1 + j) * num_user_profiles) % profiles.size]['id'],
          }
          subscribes.append(template.merge(sub))
        end
      end
      UserFeedSubscription.insert_all!(subscribes)

      puts "adding tags..."
      tags = []
      for i in 1..num_tags do
        tag = {name: "tag#{i}"}
        tags.append(template.merge(tag))
      end
      tags = Tag.insert_all!(tags, returning: [:id]).to_a

      puts "adding memes..."
      memes = []
      for i in 1..num_memes do
        meme = {
          profile_id: profiles[i % (num_users * num_user_profiles)]['id'],
          title: "meme#{i}",
          image: "https://external-preview.redd.it/zvWqlwlPYK5Sh7BSIuB5lDIsYi7qbk3tlhrouio0UvI.jpg?auto=webp&s=008efa7173755760c2bd1b992707e00a67344b70"
        }
        memes.append(template.merge(meme))
      end
      memes = Meme.insert_all!(memes, returning: [:id]).to_a

      puts "tagging memes..."
      meme_tags = []
      cur_tag = 0
      for m in memes do
        meme_tags.append(template.merge({meme_id: m['id'], tag_id: tags[cur_tag]['id']}))
        cur_tag = (cur_tag + 1) % tags.size
      end
      meme_tags = MemeTag.insert_all!(meme_tags)

      puts "adding matches..."
      # user 1 likes everyone
      matches = []
      for u in users do
        # Match.new( sender_id: current_user.id, receiver_id: matchUserId, liked: false )
        match = {
          sender_id: first_user.id,
          receiver_id: u['id'],
          liked: false
        }
        matches.append(template.merge(match))
      end
      matches = Match.insert_all!(matches)

    end
    conversation.users << User.all
    render json: {:message => 'seeded'}.to_json, status: :ok
  end

  def reset
    ActiveRecord::Tasks::DatabaseTasks.truncate_all(Rails.env)


    ActiveRecord::Base.connection.tables.each do |table|
      puts "Resetting auto increment ID for #{table} to 1"
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end

    render json: {:message => 'reset'}.to_json, status: :ok
      
  end


  def create
    user_params = params.require(:session).permit(:username, :password)
    user = User.find_by(username: user_params[:username].downcase)
    if user && user.authenticate(user_params[:password])
      log_in user
      if (url = session[:prelogin_url]) == nil
        redirect_to controller: 'home', action: 'index'
      else
        session.delete(:prelogin_url)
        redirect_to url
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unauthorized
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
