class UsersController < ApplicationController
  has_filters %w{proposals debates comments spending_proposals}, only: :show

  load_and_authorize_resource
  helper_method :authorized_for_filter?
  helper_method :author_or_admin?

  def show
    load_filtered_activity if valid_access?
  end

  private
    def set_activity_counts
      @activity_counts = HashWithIndifferentAccess.new(
                          proposals: Proposal.where(author_id: @user.id).count,
                          debates: Debate.where(author_id: @user.id).count,
                          comments: Comment.not_as_admin_or_moderator.where(user_id: @user.id).count,
                          spending_proposals: SpendingProposal.where(author_id: @user.id).count)
    end

    def load_filtered_activity
      set_activity_counts
      case params[:filter]
      when "proposals" then load_proposals
      when "debates"   then load_debates
      when "comments"  then load_comments
      when "spending_proposals"  then load_spending_proposals if author_or_admin?
      else load_available_activity
      end
    end

    def load_available_activity
      if @activity_counts[:proposals] > 0
        load_proposals
        @current_filter = "proposals"
      elsif  @activity_counts[:debates] > 0
        load_debates
        @current_filter = "debates"
      elsif  @activity_counts[:comments] > 0
        load_comments
        @current_filter = "comments"
      elsif  @activity_counts[:spending_proposals] > 0 && author_or_admin?
        load_spending_proposals
        @current_filter = "spending_proposals"
      end
    end

    def load_proposals
      @proposals = Proposal.where(author_id: @user.id).order(created_at: :desc).page(params[:page])
    end

    def load_debates
      @debates = Debate.where(author_id: @user.id).order(created_at: :desc).page(params[:page])
    end

    def load_comments
      @comments = Comment.not_as_admin_or_moderator.where(user_id: @user.id).includes(:commentable).order(created_at: :desc).page(params[:page])
    end

    def load_spending_proposals
      @spending_proposals = SpendingProposal.where(author_id: @user.id).order(created_at: :desc).page(params[:page])
    end

    def valid_access?
      @user.public_activity || authorized_current_user?
    end

    def author_or_admin?
      @author_or_admin ||= current_user && (current_user == @user || current_user.administrator?)
    end

    def authorized_current_user?
      @authorized_current_user ||= current_user && (current_user == @user || current_user.moderator? || current_user.administrator?)
    end

    def authorized_for_filter?(filter)
      filter == "spending_proposals" ? author_or_admin? : true
    end
end
