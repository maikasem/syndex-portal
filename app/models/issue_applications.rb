# frozen_string_literal: true

class IssueApplications < ApplicationRecord
    belongs_to :account, class_name: 'Account'
    belongs_to :issue, class_name: 'Issue'
end
