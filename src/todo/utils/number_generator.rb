# frozen_string_literal: true

module ToDo
  module NumberGenerator
    def even_generator(n)
      (1..Float::INFINITY)
        .lazy
        .select(&:even?)
        .take(n)
    end
  end
end
