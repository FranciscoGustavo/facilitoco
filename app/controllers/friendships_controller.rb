class FriendshipsController < ApplicationController
	before_action :find_friend, except:[:index, :update]
	before_action :find_friendship, only:[:update]

	def index
		#@pending_friendships = Friendship.pending_for_user(current_user)
		#@accepted_friendships = Friendship.accepted_for_user(current_user)

		@pending_friendships = current_user.followers.pending.decorate
		@accepted_friendships = current_user.followers.active.decorate

		@pending_request = current_user.friendships.decorate
	end

	def create
		friendship = Friendship.new(user: current_user, friend: @friend)
		respond_to do |format|
			if friendship.save
				format.html { redirect_to @friend }
				format.js
			else
				format.html { redirect_to @friend, notice: "Error con la solicitusd de amistad" }
				format.js
			end
		end

	end

	def update
		if params[:status] == "1"
			@friendship.accepted!
		elsif params[:status] == "0"
			@friendship.rejected!
		end

		respond_to do |format|
			format.html { redirect_to friendships_path }
		end
	end

	private

	def find_friendship
		@friendship = Friendship.find(params[:id])
	end

	def find_friend
		@friend = User.find(params[:friend_id])
	end
end