class Point < Matr

  def initialize(*args)
    super(args.length, 1, args.map { |n| [n] })
  end

end
