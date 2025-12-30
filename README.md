# FPGA Elevator

This project implements a digital elevator control system designed for FPGA deployment. It manages the logic for a 8 floor elevator, including movement direction, floor tracking, and door opening/closing timing sequences using a Finite State Machine (FSM).

## 🏢 System Overview
The system accepts a target floor request (`etaj_cerut`) and orchestrates the elevator's movement to reach that floor. It uses a frequency divider to simulate realistic timing for door operations and motor signals.

### Key Features
* **FSM-Driven Control:** A robust 4-state machine (`idle`, `door_close`, `move_up`, `move_down`) manages the entire operational lifecycle.
* **Safety Delays:** Dedicated logic ensures doors are fully closed before movement begins and fully open before returning to idle.
* **Floor Tracking:** A bidirectional counter (`floor_counter`) tracks the current position in real-time based on `sus` (up) and `jos` (down) signals.
* **Simulated Timing:** A door counter simulates the mechanical delay of opening and closing doors.

## 🏗️ Architecture
The design follows a modular architecture managed by a `top.sv` module:

1. **FSM (`fsm.sv`):** The central brain that decides *next states* and outputs motor control signals (`sus`, `jos`).
2. **Floor Counter (`floor_counter.sv`):** Tracks the elevator's physical location (`etaj_curent`).
3. **Door Counter (`door_counter.sv`):** Acts as a timer to ensure doors remain open/closed for a set duration (3 cycles).
4. **Decoder (`decodor_1_hot.sv`):** Converts the current floor number into a 1-hot encoding for display output (e.g., LED floor indicators).
5. **Clock Divider (`freq_div.sv`):** Scales the 100MHz system clock down to a human-readable speed (2Hz).



## 🚦 State Machine Logic
* **Idle:** Waiting for requests. Moves to `door_close` if `etaj_cerut != etaj_curent`.
* **Door Close:** Simulates doors closing. Moves to `move_up` or `move_down` after timer completes.
* **Move Up:** Motor moves elevator up. Stops when `etaj_cerut == etaj_curent + 1`.
* **Move Down:** Motor moves elevator down. Stops when `etaj_cerut == etaj_curent - 1`.
* **Door Open:** Simulates doors opening. Returns to `idle` after timer completes.

## 🛠️ Hardware Mapping
* **Inputs:**
    * `etaj_cerut` [2:0]: Switches to select the target floor.
    * `reset`: Button to reset the system to the ground floor.
    * `clk_100MHz`: System clock.
* **Outputs:**
    * `out` [7:0]: LEDs indicating the current floor (One-Hot encoded).

To simulate realistic timing, ensure the `freq_div` module is set to a low divider (e.g., `count_max = 2`). For physical hardware, set `count_max` to `25000000` for a 2Hz clock.
