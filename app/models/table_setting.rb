class TableSetting < ApplicationRecord

  belongs_to :company

  validates :entity, presence: true
  validates :column_key, presence: true

  def self.position(entity:, column_key:, company:)

    setting = find_or_create_by!(
      entity: entity.to_s,
      column_key: column_key.to_s,
      company_id: company.id
    )

    if setting.position.zero?
      setting.update!(
        position: where(
          entity: entity.to_s,
          company_id: company.id
        ).maximum(:position).to_i + 1
      )
    end

    setting.position

  end


  def self.update_positions(entity:, columns:, company:)

    columns.each_with_index do |column_key, index|

      find_or_create_by!(
        entity: entity.to_s,
        column_key: column_key.to_s,
        company_id: company.id
      ).update!(
        position: index + 1
      )

    end

  end

end