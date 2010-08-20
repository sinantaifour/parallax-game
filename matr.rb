# Implements a matrix with operations on it.
class Matr

  attr_reader :m, :n

  def initialize(m, n, content)
    raise MatrixError, "Wrong number of rows" if content.length != m
    raise MatrixError, "Wrong number of columns" unless content.map { |r| r.length == n }.all?
    @m, @n = m, n
    @content = content
  end

  def [](i, j = 1)
    raise MatrixError, "Access out of range" if i <= 0 or j <= 0 or i > m or j > n
    @content[i-1][j-1]
  end

  def row(i)
    raise MatrixError, "Access out of range" if i <= 0 or i > m
    @content[i-1]
  end

  def col(j)
    raise MatrixError, "Access out of range" if j <= 0 or j > n
    @content.map { |r| r[j-1] }
  end

  def *(mat)
    raise MatrixError, "Incompatible matrix sizes" unless self.n == mat.m
    res = (0...self.m).to_a.map { [] }
    self.m.times do |i|
      mat.n.times do |j|
        res[i][j] = self.row(i+1).zip(mat.col(j+1)).inject(0) { |s, t| s + t.first * t.last }
      end
    end
    Matr.new(self.m, mat.n, res)
  end

end

class MatrixError < StandardError; end

class Point < Matr

  def initialize(*args)
    super(args.length, 1, args.map { |n| [n] })
  end

  def eq(other)
    return false if other.m != self.m or other.n != 1
    return (1..self.m).map { |i| self[i, 1] == other[i, 1] }.all?
  end

  def identifier
    "#{m}," + (1..self.m).map { |i| self[i, 1].to_f.to_s }.join(",")
  end

end
