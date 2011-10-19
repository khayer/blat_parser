module BlatParser
  class Parser
    include Enumerable
    def initialize(filename = nil, outdir=nil, no_pointers=true)
      if no_pointers
        self.parse_to_file_2(filename, outdir)
      else
        @unique_mapper_pos = []
        @non_unique_mapper_pos = []
        @current_iteration = 0
        @outdir = outdir
        if filename
          @filehandler = ::File.open(filename)
          @list_of_lines = []
          @list_of_header = []
          position = @filehandler.pos
          @filehandler.each do |line|
            aline = line.split()
            if !is_a_number?(aline[0])
              @list_of_header << position
            else
              @list_of_lines << position
            end
            position = @filehandler.pos
          end

          self.parse_to_file()
          @current_iteration = 0
        else
          @filehandler = nil
          @list_of_lines = []
          @list_of_header = []
        end
      end
    end

    attr_accessor :list_of_lines, :current_iteration, :list_of_header, :unique_mapper_pos, :non_unique_mapper_pos

    def next()
      position = @list_of_lines[@current_iteration]
      if position
        @filehandler.pos = position
      else
        return nil
      end
      if @list_of_lines.length >= @current_iteration
        @current_iteration += 1
      else
        return nil
      end
      make_content()
    end

    def make_content()
      content = BlatParser::BlatContent.new(@filehandler.read())
    end

    def make_content_2(line)
      content = BlatParser::BlatContent.new(line)
    end



    def each

        for i in @list_of_lines
          yield self.next()
        end

    end

    # parse into unique and non-unique mappers

    def parse()
      @filehandler.pos = 0
      #puts @filehandler.pos
      qnames = []
      pos = []

      self.map  {|content|
        #puts content.qname
        qnames << content.qname()
        pos << @current_iteration
      }

      counter_non_unique = 0
      counter_unique = 0


      while !qnames.empty?()

        element1 = qnames.pop()
        pos1 = pos.pop()

        if qnames.include?(element1)
          counter_non_unique += 1
          @non_unique_mapper_pos << pos1
          while qnames.include?(element1)
            ind = qnames.index(element1)
            qnames.delete_at(ind)
            pos2 = pos.delete_at(ind)
            @non_unique_mapper_pos << pos2
          end
        else
          counter_unique += 1
          @unique_mapper_pos << pos1
        end
      end
      puts "Unique: #{counter_unique}    Non_unique: #{counter_non_unique}"
    end

    def content_at(x)
      if x < 0
        raise "Invalid entry number!"
      end
      if x > @list_of_lines.length()
        raise "There are only #{@list_of_lines.length} entries!"
      end
      @current_iteration = x
      self.next()
    end

    # a little helper
    def is_a_number?(s)
      s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end

    def non_unique_to_s()
      entries_to_s(@non_unique_mapper_pos)
    end

    def unique_to_s()
      entries_to_s(@unique_mapper_pos)
    end


    def parse_to_file()
      @filehandler.pos = 0
      #puts @filehandler.pos
      qnames = []
      pos = []


      counter_non_unique = 0
      counter_unique = 0
      z_non_unique = File.new(@outdir+"_non_unique",'w')
      z_unique = File.new(@outdir+"_unique", 'w')
      out = ""

      entry1 = self.next()
      entry2 = self.next()

      while entry2!=nil
        #entry2 = self.next
        if entry1.qname == entry2.qname
          counter_non_unique += 1
          out = "#{entry1.to_s()}"
          z_non_unique.write(out+"\n")
          while entry1.qname == entry2.qname
            out = "#{entry2.to_s()}"
            z_non_unique.write(out+"\n")
            entry2 = self.next
            if entry2 == nil
              break
            end
          end
        else
          counter_unique += 1
          out = "#{entry1.to_s()}"
          z_unique.write(out+"\n")
          entry1 = entry2
        end
      end

      out = "#{entry1.to_s()}"
      z_unique.write(out+"\n")

      puts "Unique: #{counter_unique}    Non_unique: #{counter_non_unique}"
      z_non_unique.close
      z_unique.close
    end

    def parse_to_file_2(filename, outdir)

      @filehandler = File.new(filename, 'r')
      z_unique = File.new(outdir+"_unique", 'w')
      z_non_unique = File.new(outdir+"_non_unique", 'w')

      counter_non_unique = 0
      counter_unique = 0


      while !@filehandler.eof?
        line = @filehandler.readline()
        aline = line.split()
        if is_a_number?(aline[0])
          entry1 = make_content_2(line)
          #puts entry1.qname
          if @filehandler.eof?()
            counter_unique += 1
            break
          else
            line = @filehandler.readline()
            entry2 = make_content_2(line)

            while !@filehandler.eof?

              if entry1.qname == entry2.qname
                counter_non_unique += 1
                out = "#{entry1.to_s()}"
                z_non_unique.write(out+"\n")
                while entry1.qname == entry2.qname
                  puts entry1.qname
                  out = "#{entry2.to_s()}"
                  z_non_unique.write(out+"\n")
                  if !@filehandler.eof?()
                    line = @filehandler.readline()
                    entry2 = make_content_2(line)
                  end
                end
                entry1 = entry2
                if !@filehandler.eof?()
                  line = @filehandler.readline()
                  entry2 = make_content_2(line)
                else
                  counter_unique += 1
                end
              else
                counter_unique += 1
                out = "#{entry1.to_s()}"
                z_unique.write(out+"\n")
                entry1 = entry2
              end
            end
          end
        end
      end
      out = "#{entry1.to_s()}"
      z_unique.write(out+"\n")

      puts "Unique: #{counter_unique}    Non_unique: #{counter_non_unique}"
      z_non_unique.close
      z_unique.close
    end



    private
    def entries_to_s(positions)
      z = File.new(@outdir,'w')
      out = ""

      for pos in positions
          pos = pos - 1
          entry = content_at(pos)
          out = "#{entry.to_s()}"
          z.write(out+"\n")
      end

      z.close
    end





  end
end