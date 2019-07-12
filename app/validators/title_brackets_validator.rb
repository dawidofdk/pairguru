class TitleBracketsValidator < ActiveModel::Validator
  BRACKETS = %w(() {} []).freeze

  def validate(record)
    record.errors.add(:title, "has invalid brackets") unless all_brackets_closed?(record.title)
  end

  private

  def all_brackets_closed?(title)
    return false if BRACKETS.any? { |b| title.include?(b) }

    brackets_sequence = title.chars.select { |c| c.in?(BRACKETS.join) }.join

    loop do
      seq_size = brackets_sequence.size
      brackets_sequence.remove!(*BRACKETS)
      break if seq_size.eql?(brackets_sequence.size)
    end

    brackets_sequence.empty?
  end
end
