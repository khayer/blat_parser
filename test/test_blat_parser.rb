require 'test/unit'
require_relative '../lib/blat_parser'

class MyUnitTests < Test::Unit::TestCase

	def setup()
		#@current_file = MyParser::FastaParser.new()
		#@current_file.open("vertebrate_mammalian.2.rna.fna")
	end

	def test_combine_fasta_parse_to_file()
   out = "example1_modified_combined.fa"
   test_combination = BlatParser::CombineFasta.new("example1_R1_modified.fa", "example1_R2_modified.fa", out)
   test_combination.parse_to_file()
   assert(File.exist?(out))
   #File.open(out)




	 #assert_equal(@current_file.list_of_positions.length, 14703)
	 #assert_equal(@current_file.list_of_positions[0],0)
	end

  def test_combine_fasta_parse_to_file2()
   out = "example_1_combined.fa"
   test_combination = BlatParser::CombineFasta.new("example1_R1_001.fasta", "example1_R2_001.fasta", out)
   test_combination.parse_to_file()
   assert(File.exist?(out))
   #File.open(out)




   #assert_equal(@current_file.list_of_positions.length, 14703)
   #assert_equal(@current_file.list_of_positions[0],0)
  end




end