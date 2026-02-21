Traffic Light Control System using FSM (Verilog)

Project Overview
This project implements a Traffic Light Control System using Finite State Machine (FSM) architecture in Verilog HDL.  
The system includes normal traffic sequencing, emergency vehicle priority handling, and pedestrian crossing support.

The design was simulated, verified, and taken through physical design flow using OpenROAD.



Features
- Normal traffic signal state transitions
- Emergency vehicle override mechanism
- Pedestrian request handling
- Structured FSM-based design
- RTL to Physical Layout flow


simulation result : 

![Simulation Waveform](images/simulation_waveform.png)


 System Architecture
The system is designed using FSM concepts (Moore/Mealy model) with defined states such as:
- S0 – Main Road Green
- S1 – Main Road Yellow
- S2 – Side Road Green
- S3 – Pedestrian Mode
- S4 – Emergency Mode



Tools & Their Role

Tool        Role 
Linux      | Development Environment 
Verilog HDL| RTL Design 
Testbench  | Functional Verification 
GTKWave    | Waveform Analysis 
Vivado     | RTL Simulation 
OpenROAD   | Physical Design & Layout 
