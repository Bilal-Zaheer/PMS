# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments, &:timestamps
  end
end
