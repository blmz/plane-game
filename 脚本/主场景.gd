extends Node2D

const 尖刺模块 = preload("res://场景/尖刺模块.tscn")

@onready var 尖刺生成位置: Marker2D = $尖刺生成位置
@onready var timer: Timer = $Timer
@onready var 前景: Parallax2D = $前景
@onready var 背景: Parallax2D = $背景
@onready var 小飞机: AnimatedSprite2D = $小飞机
@onready var 飞机初始位置: Marker2D = $飞机初始位置
@onready var 操作提示: Node2D = $操作提示
@onready var ui: CanvasLayer = $Camera2D/UI
@onready var 前景图: Sprite2D = $前景/前景图
@onready var 前景图2: Sprite2D = $前景/前景图2

@export var 加速倒计时间:float=10
@export var 前景速度:float=200
@export var 背景速度:float=81

var 加速系数:float=1.0
var 分数:int=0

var 尖刺列表=[]

var 当前时间=0.0
var 生成时间=2.5

var 是否开始:bool=false
var 操作禁止:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    小飞机.死亡信号.connect(游戏结束)
    ui.重开信号.connect(场景准备)
    场景准备()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if !是否开始:
        return
    当前时间-=delta
    if 当前时间<=0:
        生成尖刺()
        当前时间=生成时间-0.5*加速系数

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("鼠标左键") and !操作禁止 and !是否开始:
        游戏开始()

func 游戏结束():
    是否开始=false
    操作禁止=true
    ui.游戏结束()

func 场景准备():
    全局脚本.分数=0
    前景图.texture=全局脚本.主题贴图字典.get(全局脚本.主题列表[全局脚本.当前主题]+"地")
    前景图2.texture=全局脚本.主题贴图字典.get(全局脚本.主题列表[全局脚本.当前主题]+"地")
    for i in 尖刺列表:
        if i :
            i.queue_free()
    小飞机.初始化()
    小飞机.position=飞机初始位置.position
    操作提示.visible=true
    操作禁止=false

func 游戏开始():
    加速系数=1.0
    前景.autoscroll.x=-200
    背景.autoscroll.x=-80
    分数=0
    timer.start(加速倒计时间)
    小飞机.是否开始=true
    是否开始=true
    操作提示.visible=false

func 生成尖刺():
    var 尖刺实例=尖刺模块.instantiate()
    add_child(尖刺实例)
    尖刺实例.position=尖刺生成位置.position
    尖刺实例.scale=Vector2.ONE*0.745
    尖刺实例.移动速度=-前景.autoscroll.x
    尖刺列表.append(尖刺实例)

func _on_timer_timeout() -> void:
    加速系数+=0.1
    前景.autoscroll.x-=加速系数*10
    背景.autoscroll.x-=加速系数*10
    for i in 尖刺列表:
        if i :
            i.移动速度=-前景.autoscroll.x
    timer.start(加速倒计时间)
