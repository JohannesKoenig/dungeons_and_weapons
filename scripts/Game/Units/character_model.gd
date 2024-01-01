class_name CharacterModel

var texture: String
var instructions: Dictionary


static func new_from_parameters(texture_path: String, instructions: Dictionary) -> CharacterModel:
	var model = CharacterModel.new()
	model.texture = texture_path
	model.instructions = instructions
	return model

