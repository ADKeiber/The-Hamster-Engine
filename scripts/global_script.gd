extends Node
#Script used to hold global signals, state or anything else where need to exist between loosely coupled nodes
signal close_popups
var roster_limit: int = 4
var num_of_wheels: int
var roster: Array[HamsterStats]
var power_generated : float = 0
var power_drain : float = 0.01
var hamster_watts_produced : int = 0
var hamster_watts_min : int = 0

var currently_installed_modules: Array[MachineModule]
var currently_available_modules: Array[MachineModule]
var all_modules: Array[MachineModule]
