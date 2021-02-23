class MatchesController < ApplicationController
    before_action :require_login

    def index
        @match_profiles = []
        previouslyMatchedIds = [current_user.id]
        # First, grab all matches who have liked you but you have not liked them back
        likedMeIds = Match.where("liked = FALSE AND (user1_id = :user_id OR user2_id = :user_id)", {user_id: current_user.id})
        if likedMeIds != nil 
            
            likedMeIds.each do |match|
                match_id = match.user1_id == current_user.id ?  match.user2_id : match.user1_id
                newProfile = Profile.where(user_id: match_id).sample
                @match_profiles.append(newProfile)
                previouslyMatchedIds.append(match_id)
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
end
