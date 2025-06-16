extends Node2D

@onready var 上尖刺1: Sprite2D = $上尖刺1
@onready var 下尖刺1: Sprite2D = $下尖刺1
@onready var 星星位置1: Sprite2D = $星星位置1

var 上尖刺列表:Array[Sprite2D]
var 下尖刺列表:Array[Sprite2D]
var 星星尖刺列表:Array[Sprite2D]
var 移动速度:float=200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var 随机值=randf_range(-0.5,0.5)
    上尖刺1.scale.y+=随机值
    下尖刺1.scale.y-=随机值
    星星位置1.position+=randf_range(-200,200)*Vector2.DOWN
    切换主题()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    position+=移动速度*delta*Vector2.LEFT

func 切换主题():
    上尖刺1.texture=全局脚本.主题贴图字典.get(全局脚本.主题列表[全局脚本.当前主题]+"刺")
    下尖刺1.texture=全局脚本.主题贴图字典.get(全局脚本.主题列表[全局脚本.当前主题]+"刺下")

func _on_碰撞体_area_entered(area: Area2D) -> void:
    if area.is_in_group("消失"):
        queue_free()
