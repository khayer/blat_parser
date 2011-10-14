module BlatParser
  class CombineFasta

    def initialize(filename1, filename2, outdir)

      @f1 = File.new(filename1, 'r')
      @f2 = File.new(filename2, 'r')
      @outdir = outdir

    end

    def parse_to_file()
      i = 0
      str_n = ""
      while i<50
        str_n = "@{str_n}N"
      end
      f_out = File.new(@outdir,'w')

      while !f2.eof?()
        line1 = @f1.readline().chomp
        line2 = @f2.readline().chomp
        if line1.include?('>')
          str = "#{line1}\t#{line2}"
        else
          str = "#{line1}#{str_n}#{line2}"
        end
        f_out.write(str+"\n")
      end



    end

  end
end