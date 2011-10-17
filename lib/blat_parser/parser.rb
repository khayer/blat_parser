module BlatParser
  class Parser
    include Enumerable
    def initialize(filename = nil)
      @unique_mapper_pos = []
      @non_unique_mapper_pos = []
      @current_iteration = 0
      if filename
        @filehandler = ::File.open(filename)
        @list_of_lines = []
        @list_of_header = []
        position = @filehandler.pos
        @filehandler.each do |line|
          aline = line.split()
          if aline[0] =~ /(@.)/
            @list_of_header << position
          else
            @list_of_lines << position
          end
          position = @filehandler.pos
        end

        self.parse()
        @current_iteration = 0
      else
        @filehandler = nil
        @list_of_lines = []
        @list_of_header = []
      end
    end

    def to_s()
      str = @matches+"\t"+@misMatches+"\t"+@repMatches+"\t"+@nCount+"\t"+@qNumInsert+"\t"+@qBaseInsert+"\t"+@tNumInsert+"\t"+@tBaseInsert+"\t"+@strand+"\t"+@qname+"\t"+@qSize+"\t"+@qStart+"\t"+@qEnd+"\t"+@tName+"\t"+@tSize+"/t"+@tStart+"/t"+@tEnd+"/t"+@blockCount+"/t"+@blockSizes+"/t"+@qStarts+"/t"+@tStarts
    end




  end
end