# frozen_string_literal: true

class IssuesController < ApplicationController
  skip_before_action :authenticate, only: %i[index]
  before_action :set_issue, only: %i[show apply]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end


  def create
    #IssueApplications.all(:conditions => ["account_id = 10 AND issue_id = 10"])
    #IssueApplications.all(:conditions => ["account_id = :account_id AND issue_id <= :issue_id", { :account_id => 10, :issue_id => 10 }])

    testt = IssueApplications.where("account_id = ? AND issue_id = ?", 1, 1)
    puts("################################################################################")
    puts(testt.length)
    puts("################################################################################")

    all_params = issue_application_params
    account_param = Account.find(all_params["account_id"])
    if issue_application_security_check(account_param.id)
      issue_param = Issue.find(all_params["issue_id"])
      @issue_application = IssueApplications.new(:account => account_param, :issue => issue_param)
      respond_to do |format|
        if @issue_application.save
          format.html {  redirect_to controller: "issues", action: "show", issue_id: all_params["issue_id"], notice: 'Application submitted successfully.' } 
        else
          format.html {  redirect_to controller: "issues", action: "show", issue_id: all_params["issue_id"], notice: 'Failed to submit the application'} 
        end
      end
    else
      respond_to do |format|
        format.html {  redirect_to controller: "issues", action: "show", issue_id: all_params["issue_id"], notice: 'Invalid Account ID detected' } 
      end
    end
  end

  def issue_application_security_check(param_account_id)
    if current_account.id == param_account_id
      return true
    else
      current_account.related_accounts.each do |account|
        if account.id == param_account_id
          return true
        end
      end
    end
    return false
  end

  def already_applied(issue_id, account_id)
   # issuedApplication = IssueApplications.find(account_id, issue_id)
     issuedApplication = IssueApplications.first(:conditions => ["account_id = 10 AND issue_id = 10"])
     puts(issuedApplication)
    end

  def show
    @accounts = []
    @accounts << current_account
    current_account.related_accounts.each do |account|
      @accounts << account
    end
  end

  private 
  
  def set_issue
    @issue = Issue.find(params[:issue_id])
  end

  def issue_application_params
    params.require(:issue_applications).permit(:account_id, :issue_id)
  end
end
