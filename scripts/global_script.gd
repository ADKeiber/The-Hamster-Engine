extends Node
#Script used to hold global signals, state or anything else where need to exist between loosely coupled nodes
signal close_popups
signal unlock_module(slot_num:int, is_project_module:bool)
signal win_game

var roster_limit: int = 4
var num_of_wheels: int
var roster: Array[HamsterStats]
var power_stored : int
var hamster_watts_produced : int = 0
var hamster_watts_min : int = 10
var battery_capacity: int = 1000
var all_modules: Array[MachineModule] = []
