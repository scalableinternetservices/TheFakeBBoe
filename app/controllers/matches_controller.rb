class MatchesController < ApplicationController
    before_action :require_login

    def index
        @match_profiles = []
        previouslyMatchedIds = [current_user.id]
        # First, grab all matches who have liked you but you have not liked them back
        likedMeIds = Match.where("liked = FALSE AND receiver_id = :user_id", {user_id: current_user.id})
        if likedMeIds != nil

            likedMeIds.each do |match|
                newProfile = Profile.where(user_id: match.sender_id).sample
                if newProfile != nil
                    @match_profiles.append(newProfile)
                    previouslyMatchedIds.append(match.sender_id)
                end
            end
        end

        # Next, grab random users until you fill up to 10 profiles or you run out
        if @match_profiles.count < 10 

            # This is ignoring nil user_ids, which is not an allowable case but we have no idea why
            otherProfiles = Profile.where.not(user_id: previouslyMatchedIds).sample(20)
            if otherProfiles != nil
                @match_profiles = @match_profiles + otherProfiles
            end
        end

    end

    def matchSuccess 
        if Conversation.exists?(id: params[:id]) and User.exists?(id: params[:user1_id]) and User.exists?(id: params[:user2_id])
            @conversation = Conversation.find(params[:id])
            @user1 = User.find(params[:user1_id])
            @user2 = User.find(params[:user2_id])
            respond_to do |format|
                format.html { render :template => "matches/match_success" }
            end
        else
            redirect_to matches_url
        end
    end

    def likeProfile 
        profileFound = Profile.find(params[:data][:profile_id])
        matchUserId = profileFound.user_id

        matchFound = Match.where("liked = FALSE AND sender_id = :match_user_id AND receiver_id = :current_user_id", {current_user_id: current_user.id, match_user_id: matchUserId})
        helpers.subscribe_if_not_exists(profileFound,current_user)
        if matchFound.count > 0
            p "Match found", matchFound
            matchFound.each do |match|
                match.update(liked: true)
            end

            matchUser = User.find(matchUserId)
            # Create new conversation
            newConversation = Conversation.new(name: "#{current_user.username} + #{matchUser.username} 5ever UwU")
            if newConversation.save
                newConversation.users << matchUser
                newConversation.users << current_user

                respond_to do |format|
                    format.html { redirect_to match_success_path(id: newConversation.id, user1_id: current_user.id, user2_id: matchUser.id) }
                    format.json { render :index, status: :ok }
                end
            else
                respond_to do |format|
                    format.html { redirect_to matches_url, notice: "Error. Failed to create conversation" }
                    format.json { render :index, status: :unprocessable_entity }
                end
            end

        else
            # First, check if you already like them
            alreadyLiked = Match.where("liked = FALSE AND sender_id = :current_user_id", {current_user_id: current_user.id})
            newMatch = Match.new( sender_id: current_user.id, receiver_id: matchUserId, liked: false )
            if alreadyLiked.count > 0 or newMatch.save
                respond_to do |format|
                    format.html { redirect_to matches_url, notice: "You've liked #{profileFound.name}" }
                    format.json { render :index, status: :ok }
                end
            else
               
                respond_to do |format|
                    format.html { redirect_to matches_url, notice: "Database Error" }
                    format.json { render :index, status: :unprocessable_entity }
                end
            end
            
        end

    end

    private

end
