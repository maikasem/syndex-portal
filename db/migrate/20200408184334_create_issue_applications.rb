# frozen_string_literal: true

class CreateIssueApplications < ActiveRecord::Migration[6.0]
    def change
      create_table :issue_applications do |t|
        t.references :account, null: false, foreign_key: { to_table: :accounts }
        t.references :issue, null: false, foreign_key: { to_table: :issues }
        t.timestamps
      end
     # add_index :relationships, %i[account_id issue_id], unique: true, name: 'index_issue_on_account_ids_unique'
    end
  end
  