class Smartsend::Parcel
  attr_accessor :shipped_at, :reference, :weight, :height, :width, :length, :size, :freetext_lines, :items

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    params = {
      :shipdate  => @shipped_at,
      :reference => @reference,
      :weight    => @weight,
      :height    => @height,
      :width     => @width,
      :length    => @length,
      :size      => @size,
      :items     => @items.to_a.map(&:serialize)
    }

    freetext_lines.to_a.each_with_index do |line, i|
      params["freetext#{i.next}".to_sym] = line
    end

    params

  end

end
