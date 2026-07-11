class TableSetting < ApplicationRecord

  validates :entity, presence: true
  validates :column_key, presence: true

  def self.position(entity:, column_key:)

    setting = find_or_create_by!(
      entity: entity.to_s,
      column_key: column_key.to_s
    )

    if setting.position.zero?
      setting.update!(
        position: where(entity: entity).maximum(:position).to_i + 1
      )
    end

    setting.position

  end


  def self.update_positions(entity:, columns:)

    columns.each_with_index do |column_key, index|

      find_or_create_by!(
        entity: entity.to_s,
        column_key: column_key.to_s
      ).update!(
        position: index + 1
      )

    end

  end

end