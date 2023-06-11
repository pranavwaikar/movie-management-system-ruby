# frozen_string_literal: true

# This is the inmoemory storage implementation for repository interface
class InMemoryStorage
  def initialize
    @users = []
  end

  def find(id)
    @users.find { |user| user[:id] == id }
  end

  def find_by(field_name, target_value)
    @users.find { |user| user[field_name.to_sym] == target_value }
  end

  def filter_by(field_name, target_value)
    @users.select { |user| user[field_name.to_sym] == target_value }
  end

  def all
    @users
  end

  def find_index_by_id(target_id)
    target_index = -1
    @users.each_with_index do |user, index|
      if user[:id] == target_id
        target_index = index
        break
      end
    end
    target_index
  end

  def create(user)
    user[:id] = @users.size + 1 unless user.key?(:id)
    @users.push(user)
    user
  end

  def update(user)
    index = find_index_by_id(user[:id])
    @users[index] = user
    user
  end

  def delete(id)
    @users.delete_at(find_index_by_id(id))
  end

  def truncate
    @users = []
  end
end
