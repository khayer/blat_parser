module BlatParser
  class BlatContent
    # .pslx files expected!
    def initialize(line)
      tmp = line.split(" ")
      @matches = tmp[0]
      @misMatches = tmp[1]
      @repMatches = tmp[2]
      @nCount = tmp[3]
      @qNumInsert = tmp[4]
      @qBaseInsert = tmp[5]
      @tNumInsert = tmp[6]
      @tBaseInsert = tmp[7]
      @strand = tmp[8]
      @qname = tmp[9]
      @qSize = tmp[10]
      @qStart = tmp[11]
      @qEnd = tmp[12]
      @tName = tmp[13]
      @tSize = tmp[14]
      @tStart = tmp[15]
      @tEnd = tmp[16]
      @blockCount = tmp[17]
      @blockSizes = tmp[18]
      @qStarts = tmp[19]
      @tStarts = tmp[20]
      @seq = tmp[21]
    end

    attr_accessor :qname

    def to_s()
      str = @matches+"\t"+@misMatches+"\t"+@repMatches+"\t"+@nCount+"\t"+@qNumInsert+"\t"+@qBaseInsert+"\t"+@tNumInsert+"\t"+@tBaseInsert+"\t"+@strand+"\t"+@qname+"\t"+@qSize+"\t"+@qStart+"\t"+@qEnd+"\t"+@tName+"\t"+@tSize+"/t"+@tStart+"/t"+@tEnd+"/t"+@blockCount+"/t"+@blockSizes+"/t"+@qStarts+"/t"+@tStarts+"/t"+@seq
    end




  end
end