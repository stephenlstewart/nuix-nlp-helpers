######################################
#### Create.Search.Marcros.for.NLP.rb
#### This script will iterate through all of the NLP enriched attributes in a case.
#### It will then create a search macro for each of the values.
#### It currently only creates one search macro focused on the higher range - :[.# TO 1]
#### The left hand value of the range search is configurable per type - Dictionary, SkillSet, ClassifierRisk, Entity Risk

require "find"
require "fileutils"

# Path to where Search Macros are stored.
CASE_PATH = currentCase.getLocation()
CASE_PATH_EXTENDED = "#{CASE_PATH}\\Stores\\User Data\\Search Macros\\NLP-Search"

FileUtils.mkdir("#{CASE_PATH_EXTENDED}") unless File.exists?("#{CASE_PATH_EXTENDED}")

### Process the NLP enrichmnet names, create the folders and write out the search macros.
searchMacroCounter = 0

def make_searchMacro(nlp_name,score,folderName)
	### nlp_name - this is the value for the Nuix NLP custome metadata.
	### score - this is the value used as part of the search - so either proximity OR risk.  It is set at a per Dictionary, SkillSet, ClassifierRisk, Entity Risk.
	### folderName - this the top level folder name where Dictionary, SkillSet, ClassifierRisk, Entity Risk will be written.
	nlp_name_parts = nlp_name.split('.')
	searchMacroName = ""
	searchSyntax = ""
	searchMacroFolder = ""
	#### Determine search macro details based on NLP enrichment types (Dictionary, SkillSet, ClassifierRisk, Entity Risk)
	if folderName == 'Dictionary'
		searchMacroFolder = "#{CASE_PATH_EXTENDED}\\#{folderName}\\#{nlp_name_parts[3]}\\#{nlp_name_parts[5]}"
		if nlp_name_parts.size < 6
			searchMacroName = "#{nlp_name_parts[3]}-HIGH"
		else
			searchMacroName = "#{nlp_name_parts[5]}-HIGH"
		end
		searchSyntax = "nlp:\"#{nlp_name}\":[#{score} TO 1]"
	elsif folderName == 'SkillSets'
		searchMacroFolder = "#{CASE_PATH_EXTENDED}\\#{folderName}\\#{nlp_name_parts[3]}\\"
		if nlp_name_parts.size < 4
			searchMacroName = "#{nlp_name_parts[3]}-HIGH"
		else
			searchMacroName = "#{nlp_name_parts[5]}-HIGH"
		end
		searchSyntax = "nlp:\"#{nlp_name}\":[#{score} TO 1]"
	elsif folderName == 'ClassifierRisk'
		searchMacroFolder = "#{CASE_PATH_EXTENDED}\\#{folderName}\\#{nlp_name_parts[7]}"
		searchMacroName = "#{nlp_name_parts[7]}-HIGH"
		searchSyntax = "nlp:\"#{nlp_name}\":[#{score} TO 1]"
	elsif folderName == 'EntityRisk'
		searchMacroFolder = "#{CASE_PATH_EXTENDED}\\#{folderName}\\#{nlp_name_parts[5]}"
		searchMacroName = "#{nlp_name_parts[5]}-HIGH"
		searchSyntax = "nlp:\"#{nlp_name}\":[#{score} TO 1]"
		searchSyntax = "nlp:\"#{nlp_name}\":[#{score} TO 1]"
	else
		"Error: #{nlp_name}"
	end

	#### Write out the search macro to the appropriate folder.
	begin
		FileUtils.mkdir("#{CASE_PATH_EXTENDED}\\#{folderName}") unless File.exists?("#{CASE_PATH_EXTENDED}\\#{folderName}")
		FileUtils.mkdir("#{searchMacroFolder}") unless File.exists?("#{searchMacroFolder}")
		searchMacroFile = File.new("#{searchMacroFolder}\\#{searchMacroName}.macro", "w")
		searchMacroFile.puts(searchSyntax)
		searchMacroFile.close
	rescue
		"boom"
	end
end


### Iterate through all of pieces of NLP metadata.
### Three pieces of information are provided inot the make_SearchMacro fuction

currentCase.getCustomMetadataFields('nlp').each do |nlp_name|
	if nlp_name.include? "dictionary"
		if nlp_name.include? "proximity"
			make_searchMacro(nlp_name,'.7','Dictionary')
		end
	elsif nlp_name.include? "skillsets"
		if nlp_name.include? "proximity"
			make_searchMacro(nlp_name,'.7','SkillSets')
		end
	elsif nlp_name.include? "classifierRisk"
		if nlp_name.include? "riskValue"
			make_searchMacro(nlp_name,'.8','ClassifierRisk')
		end
	elsif nlp_name.include? "entityRisk"
		if nlp_name.include? "riskValue"
			make_searchMacro(nlp_name,'.8','EntityRisk')
		end
	end
	searchMacroCounter = searchMacroCounter + 1
end
puts ""
puts "#{searchMacroCounter} Search Macros were created."
puts "Output Folder: #{CASE_PATH_EXTENDED}"
puts ""
puts ""