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
      cmd = "#{@blatdir} -out=pslx #{@database} #{@query} #{@outputdir}"
      a = Thread.new{system(cmd)}
      b = Thread.new{
        while a.alive?
          sleep 1
        end
        if a.status == nil
          raise("Blat died...")
        end
      }
      a.join
      b.join
      puts File.exist?(@outputdir)

    end

  end
end