extends AnimatedSprite2D

@onready var 尾气位置: Marker2D = $尾气位置
@onready var 碰撞检测: Area2D = $碰撞检测
const 尾气 = preload("res://场景/尾气.tscn")
var 动画列表=["红色","蓝色","绿色","黄色"]
var 重力:float=500.0
var 竖直速度:float=0
var 水平速度:float=500
var 提升速度:float=300
var 是否开始:bool=false

signal 死亡信号()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    初始化()

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("鼠标左键") and 是否开始:
        竖直速度-=提升速度
        发射尾气()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if !是否开始:
        return
    竖直速度+=重力*delta
    position+=竖直速度*Vector2.DOWN*delta
    rotation=Vector2(水平速度,竖直速度).angle()

func 初始化():
    play(动画列表.pick_random())
    visible=true
    rotation=0
    竖直速度=0

func 发射尾气():
    var 尾气实例=尾气.instantiate()
    get_parent().add_child(尾气实例)
    尾气实例.global_rotation=global_rotation
    尾气实例.global_position=尾气位置.global_position

func _on_碰撞检测_area_entered(area: Area2D) -> void:
    if area.is_in_group("墙体") and 是否开始:
        死亡信号.emit()
        是否开始=false
        visible=false
    elif area.is_in_group("星星"):
        全局脚本.分数+=1
        area.get_parent().queue_free()
