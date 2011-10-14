module BlatParser
  class CombineFasta

    def initialize(filename1, filename2, outdir)

      @f1 = File.new(filename1, 'r')
      @f2 = File.new(filename2, 'r')
      @outdir = outdir

    end

    def parse_to_file()
      while !f2.eof?()
        if

    end

  end
end