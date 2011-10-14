module BlatParser
  class PreBlat
    #runtime
    def initialize(blatdir, database, query, outputdir)
      @blatdir = blatdir
      @database = database
      @query = query
      @outputdir = outputdir
    end

    def call_blat()

    end

  end
end