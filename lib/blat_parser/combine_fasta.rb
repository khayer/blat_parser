module BlatParser
  class CombineFasta

    def initialize(filename1, filename2, outdir)

      @f1 = File.new(filename1, 'r')
      @f2 = File.new(filename2, 'r')
      @out = File.new(outdir,'w')

    end

    def parse_to_file()
      i = 0
      str_n = ""
      while i<50
        str_n = "#{str_n}N"
        i += 1
      end

      seq1 = ""
      seq2 = ""
      first = 1

      while !@f2.eof?()

        line1 = @f1.readline().chomp
        line2 = @f2.readline().chomp

        if line1.include?('>')
          tmp1 = line1.split(" ")
          tmp2 = line2.split(" ")
          if first
            seq = ""
            first = false
            header = "#{tmp1[0]}::#{tmp2[0]}"
            @out.write(header+"\n")
          else
            seq = seq1 + str_n + seq2
            seq1 = ""
            seq2 = ""
            str = "#{seq}\n#{tmp1[0]}::#{tmp2[0]}"
            @out.write(str+"\n")
          end
        else
          seq1 = seq1 + "#{line1}"
          seq2 = seq2 + "#{line2}"
        end

      end
    end
  end
end