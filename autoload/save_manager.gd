extends Node

const _SAVE_PATH: String = "user://save_data.json"


func save_game(session: Session) -> void:
	var file: FileAccess = FileAccess.open(_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(session.serialize()))
	file.close()


func load_game() -> Session:

	var session: Session = Session.new()

	if not FileAccess.file_exists(_SAVE_PATH):
		return session

	var file: FileAccess = FileAccess.open(_SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Unable to open save file")
		return session

	var content: String = file.get_as_text()
	file.close()

	var json: JSON = JSON.new()
	if json.parse(content) == OK:
		return session.deserialize(json.data)
	push_error("Unable to parse save file")
	return session


class Session:
	var score: int = 0


	func deserialize(data: Dictionary) -> Session:
		self.score = data["score"]
		return self


	func serialize() -> Dictionary:
		return {
			"score": self.score,
		}
