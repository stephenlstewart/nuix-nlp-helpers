<?xml version="1.0" encoding="UTF-8"?>
<metadata-profile xmlns="http://nuix.com/fbi/metadata-profile">
  <metadata-list>
    <metadata type="SPECIAL" name="Name" />
    <metadata type="SPECIAL" name="File Type" />
    <metadata type="SPECIAL" name="Path Name" />
    <metadata type="SPECIAL" name="Top Dictionary Name">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $currentItem
	nlp = currentCase.getNlpStore()
	proximityValue = {}
	sorted_Dictionaries = {}
	
	cm_Dictionary = ""
	cm_Name = ""
	cm_Proximity = 0
	node = nlp.getForItem(item, 'defaultModel')
	dictionaries = node.getDictionaries()
	dictionaries.each do |dictionary|
		cm_Dictionary = dictionary.getName()
		dictionary.getTopics.each do |topic|
			cm_Name = topic.getName()
			cm_Proximity = topic.getProximity
			proximityValue[:"#{cm_Dictionary} - #{cm_Name}"] = cm_Proximity.to_f
		end
	end
	sorted_Dictionaries = proximityValue.sort_by{|k,v| -v}
		#puts sorted_Dictionaries
	
	sorted_Dictionaries[0][0]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Dictionary Proximity">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $currentItem
	nlp = currentCase.getNlpStore()
	proximityValue = {}
	sorted_Dictionaries = {}
	
	cm_Dictionary = ""
	cm_Name = ""
	cm_Proximity = 0
	node = nlp.getForItem(item, 'defaultModel')
	dictionaries = node.getDictionaries()
	dictionaries.each do |dictionary|
		cm_Dictionary = dictionary.getName()
		dictionary.getTopics.each do |topic|
			cm_Name = topic.getName()
			cm_Proximity = topic.getProximity
			proximityValue[:"#{cm_Dictionary} - #{cm_Name}"] = cm_Proximity.to_f
		end
	end
	sorted_Dictionaries = proximityValue.sort_by{|k,v| -v}
		#puts sorted_Dictionaries
	
	sorted_Dictionaries[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Skillset Name">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $currentItem
	nlp = currentCase.getNlpStore()
	proximityValue = {}
	sorted_SkillSets = {}
	cm_SkillSet = ""
	cm_Name = ""
	cm_Proximity = 0
	node = nlp.getForItem(item, 'defaultModel')
	skillSets = node.getSkillSets()
	skillSets.each do |skillset|
		cm_SkillSet = skillset.getName()
		skillset.getSkills.each do |skill|
			cm_Name = skill.getName()
			cm_Proximity = skill.getProximity()
			proximityValue[:"#{cm_SkillSet} - #{cm_Name}"] = cm_Proximity.to_f
		end
	end
	sorted_SkillSets = proximityValue.sort_by{|k,v| -v}
	sorted_SkillSets[0][0]
	#sorted_SkillSets[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Skill Proximity">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $currentItem
	nlp = currentCase.getNlpStore()
	proximityValue = {}
	sorted_SkillSets = {}
	cm_SkillSet = ""
	cm_Name = ""
	cm_Proximity = 0
	node = nlp.getForItem(item, 'defaultModel')
	skillSets = node.getSkillSets()
	skillSets.each do |skillset|
		cm_SkillSet = skillset.getName()
		skillset.getSkills.each do |skill|
			cm_Name = skill.getName()
			cm_Proximity = skill.getProximity()
			proximityValue[:"#{cm_SkillSet} - #{cm_Name}"] = cm_Proximity.to_f
		end
	end
	sorted_SkillSets = proximityValue.sort_by{|k,v| -v}
	#sorted_SkillSets[0][0]
	sorted_SkillSets[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Entity Risk Name">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $current_item
	nlp = currentCase.getNlpStore()
	riskScore = {}
	sorted_EntityRisks = {}
	
	cm_EntityRisk = ""
	cm_Name = ""
	cm_RiskScore = 0
	node = nlp.getForItem(item, 'defaultModel')
	entityRisksTypes = node.getRisks()
	#puts entityRisksTypes  
	entityRisksTypes.each do |entityRiskType|
		cm_EntityRisk = entityRiskType.getName()
		if entityRiskType.getName() == "entityRisk"
			entityRiskType.getRiskTypes().each do |risk|
				cm_Name =  risk.getName()
				cm_RiskScore = risk.getRiskValue()
				riskScore[:"#{cm_Name}"] = cm_RiskScore.to_f
			end
		end
	end
	sorted_EntityRisks = riskScore.sort_by{|k,v| -v}
	sorted_EntityRisks[0][0]
	#puts sorted_EntityRisks[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Entity Risk Score">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[begin
	item = $current_item
	nlp = currentCase.getNlpStore()
	riskScore = {}
	sorted_EntityRisks = {}
	
	cm_EntityRisk = ""
	cm_Name = ""
	cm_RiskScore = 0
	node = nlp.getForItem(item, 'defaultModel')
	entityRisksTypes = node.getRisks()
	#puts entityRisksTypes  
	entityRisksTypes.each do |entityRiskType|
		cm_EntityRisk = entityRiskType.getName()
		if entityRiskType.getName() == "entityRisk"
			entityRiskType.getRiskTypes().each do |risk|
				cm_Name =  risk.getName()
				cm_RiskScore = risk.getRiskValue()
				riskScore[:"#{cm_Name}"] = cm_RiskScore.to_f
			end
		end
	end
	sorted_EntityRisks = riskScore.sort_by{|k,v| -v}
	#puts sorted_EntityRisks[0][0]
	sorted_EntityRisks[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Classifier Risk Name">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[item = $current_item
begin
	nlp = currentCase.getNlpStore()
	riskScore = {}
	sorted_EntityRisks = {}
	cm_EntityRisk = ""
	cm_Name = ""
	cm_ClassifierGroup = ""
	cm_RiskScore = 0
	node = nlp.getForItem(item, 'defaultModel')
	entityRisksTypes = node.getRisks()
	#puts entityRisksTypes  
	entityRisksTypes.each do |entityRiskType|
		cm_EntityRisk = entityRiskType.getName()
		if entityRiskType.getName() == "classifierRisk"
			entityRiskType.getRiskTypes().each do |risk|
				risk.getRiskNames().each do |riskName|
					cm_Name = riskName.getName()
					cm_ClassifierGroup = riskName.getClassifierGroup()
					#puts riskName.getRelevanceValue()
					cm_RiskScore = riskName.getRiskValue()
					riskScore[:"#{cm_ClassifierGroup} - #{cm_Name}"] = cm_RiskScore.to_f
				end
			end
		end
	end
	sorted_EntityRisks = riskScore.sort_by{|k,v| -v}
	sorted_EntityRisks[0][0]
	#sorted_EntityRisks[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
    <metadata type="SPECIAL" name="Top Classifier Risk Score">
      <scripted-expression>
        <type>ruby</type>
        <script><![CDATA[item = $current_item
begin
	nlp = currentCase.getNlpStore()
	riskScore = {}
	sorted_EntityRisks = {}
	cm_EntityRisk = ""
	cm_Name = ""
	cm_ClassifierGroup = ""
	cm_RiskScore = 0
	node = nlp.getForItem(item, 'defaultModel')
	entityRisksTypes = node.getRisks()
	#puts entityRisksTypes  
	entityRisksTypes.each do |entityRiskType|
		cm_EntityRisk = entityRiskType.getName()
		if entityRiskType.getName() == "classifierRisk"
			entityRiskType.getRiskTypes().each do |risk|
				risk.getRiskNames().each do |riskName|
					cm_Name = riskName.getName()
					cm_ClassifierGroup = riskName.getClassifierGroup()
					#puts riskName.getRelevanceValue()
					cm_RiskScore = riskName.getRiskValue()
					riskScore[:"#{cm_ClassifierGroup} - #{cm_Name}"] = cm_RiskScore.to_f
				end
			end
		end
	end
	sorted_EntityRisks = riskScore.sort_by{|k,v| -v}
	#sorted_EntityRisks[0][0]
	sorted_EntityRisks[0][1]
rescue
	""
end]]></script>
      </scripted-expression>
    </metadata>
  </metadata-list>
</metadata-profile>

