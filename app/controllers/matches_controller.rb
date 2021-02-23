class MatchesController < ApplicationController
    before_action :require_login

    def index
        @match_profiles = []

        # First, grab all matches who have liked you but you have not liked them back
        likedMeIds = Match.where("liked == FALSE AND (user1_id == :user_id OR user2_id == :user_id", (user_id: current_user.id))
        
        previouslyMatchedIds = []
        for likedMeIds do |match|
            match_id = match.user1_id == current_user.id ?  match.user2_id : match.user1_id
            newProfile = Profile.where(user_id: match_id).sample
            @match_profiles.append()
            previouslyMatchedIds.append(match_id)
        end

        # Next, grab random users until you fill up to 10 profiles or you run out
        if @match_profiles.count < 10 
            otherProfiles = Profile.order(Arel.sql('RANDOM()')).sample(20).reject! do |p|
                p.user_id.in?(previouslyMatchedIds)
            end
            @match_profiles = @match_profiles + otherProfiles
        end

    end
end
