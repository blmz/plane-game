extends Sprite2D

var 存在时间:float=0.5
var 当前时间:float=0.0
var 速度:float=400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    存在时间=randf_range(0.5,1.2)
    速度=randf_range(350,450)
    scale=scale*randf_range(0.85,1.25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    self_modulate.a=clampf(lerpf(0,1.0,1-当前时间/存在时间),0,1.0)
    if self_modulate.a==0:
        queue_free()
    当前时间+=delta
    position+=delta*速度*-Vector2.from_angle(rotation)
