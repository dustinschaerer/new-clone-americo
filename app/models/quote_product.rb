class QuoteProduct < ActiveRecord::Base

	has_many :lines

	before_destroy :ensure_not_referenced_by_any_line

  scope :table_cover, -> { where(id: [1,2,13]) }
  scope :roll_good, -> { where(id: [3,4,10,11,12,17]) }
  scope :custom_cut, -> { where(id: [5,7,8,9]) }

	private

    def ensure_not_referenced_by_any_line
      if lines.empty?
        return true
      else
        errors.add(:base, 'Lines present')
        return false
      end
    end

end
