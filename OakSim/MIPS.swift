//The MIPS Instruction Set, Version 2.1
//🐰
import Oak

extension InstructionSet
{
    public static func Oak_gen_MIPS() -> InstructionSet?
    {
        //Formats and Instructions
        var formats: [Format] = []
        var instructions: [Instruction] = []
       
        //R-Type
        formats.append(
            Format(
                ranges:
                [
                    BitRange("opcode", at: 26, bits: 6),
                    BitRange("rs", at: 21, bits: 5, parameter: 1, parameterType: .register),
                    BitRange("rd", at: 11, bits: 5, parameter: 0, parameterType: .register),
                    BitRange("funct", at: 0, bits: 6),
                    BitRange("rt", at: 16, bits: 5, parameter: 2, parameterType: .register),
                    BitRange("shamt", at: 6, bits: 5, constant: 0)
                ],
                regex: Regex("([a-zA-Z]+)\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(\\$[A-Za-z0-9]+)")!,
                disassembly: "@mnem @arg0, @arg1, @arg2"
            )
        )
       
        guard let rType = formats.last
        else
        {
            return nil
        }
       
        instructions.append(Instruction(
            "ADD",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x20],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) + Int32(bitPattern: core.registerFile[Int(core.arguments[2])]))
            }
        ))

        instructions.append(Instruction(
            "ADDU",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x21],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) &+ Int32(bitPattern: core.registerFile[Int(core.arguments[2])]))
            }
        ))

        instructions.append(Instruction(
            "SUB",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x22],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) - Int32(bitPattern: core.registerFile[Int(core.arguments[2])]))
            }
        ))
       
        instructions.append(Instruction(
            "SUBU",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x23],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) &- Int32(bitPattern: core.registerFile[Int(core.arguments[2])]))
            }
        ))
       
        instructions.append(Instruction(
            "AND",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x24],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] & core.registerFile[Int(core.arguments[2])]
            }
        ))
       
        instructions.append(Instruction(
            "OR",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x25],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] | core.registerFile[Int(core.arguments[2])]
            }
        ))

        instructions.append(Instruction(
            "XOR",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x26],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] ^ core.registerFile[Int(core.arguments[2])]
            }
        ))

        instructions.append(Instruction(
            "NOR",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x27],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = ~(core.registerFile[Int(core.arguments[1])] | core.registerFile[Int(core.arguments[2])])
            }
        ))
       
        instructions.append(Instruction(
            "SLT",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x2A],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = (Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) < Int32(bitPattern: core.registerFile[Int(core.arguments[2])])) ? 1 : 0
            }
        ))
       
        instructions.append(Instruction(
            "SLTU",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x2B],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = (core.registerFile[Int(core.arguments[1])] < core.registerFile[Int(core.arguments[2])]) ? 1 : 0
                
            },
            available: false
        ))
       
        instructions.append(Instruction(
            "JR",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x08],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] >> core.registerFile[Int(core.arguments[2])]
                
            }
        ))

        instructions.append(Instruction(
            "SLLV",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x04],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] << core.registerFile[Int(core.arguments[2])]
            }
        ))        

        instructions.append(Instruction(
            "SRLV",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x06],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] >> core.registerFile[Int(core.arguments[2])]
            }
        ))
       
        instructions.append(Instruction(
            "SRAV",
            format: rType,
            constants: ["opcode": 0x0, "funct": 0x07],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(bitPattern: core.registerFile[Int(core.arguments[1])]) >> Int32(bitPattern: core.registerFile[Int(core.arguments[2])]))
                
                
            }
        ))

        //R-Shift Subtype
        formats.append(
            Format(
                ranges:
                [
                    BitRange("opcode", at: 26, bits: 6),
                    BitRange("rs", at: 21, bits: 5, parameter: 1, parameterType: .register),
                    BitRange("rt", at: 16, bits: 5, constant: 0b00000),
                    BitRange("rd", at: 11, bits: 5, parameter: 0, parameterType: .register),
                    BitRange("shamt", at: 6, bits: 5, parameter: 2, parameterType: .immediate),
                    BitRange("funct", at: 0, bits: 6)

                ],
                regex: Regex("([a-zA-Z]+)\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(\\$?[A-Za-z0-9]+)")!,
                disassembly: "@mnem @arg0, @arg1, @arg2"
            )
        )

        guard let rsSubtype = formats.last
        else
        {
            return nil
        }
        
        instructions.append(Instruction(
            "SLL",
            format: rsSubtype,
            constants: ["opcode": 0x0, "funct": 0x00], //This means that 0x00000000 is actually an instruction in MIPS32, so I can't use it for halting or anything...
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] << UInt32(core.arguments[2])
            }
        ))

        instructions.append(Instruction(
            "SRL",
            format: rsSubtype,
            constants: ["opcode": 0x0, "funct": 0x02],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = core.registerFile[Int(core.arguments[1])] >> UInt32(core.arguments[2])
            }
        ))
       
        instructions.append(Instruction(
            "SRA",
            format: rsSubtype,
            constants: ["opcode": 0x0, "funct": 0x03],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.registerFile[Int(core.arguments[0])] = UInt32(bitPattern: Int32(core.registerFile[Int(core.arguments[1])]) >> Int32(bitPattern: UInt32(core.arguments[2])))
            }
        ))

        //All-Const Subtype
        formats.append(
            Format(
                ranges: [
                    BitRange("const", at: 0, bits: 32)
                ],
                regex: Regex("([a-zA-Z]+)")!,
                disassembly: "@mnem"
            )
        )
       
        guard let allConstSubtype = formats.last
        else
        {
            return nil
        }

        instructions.append(Instruction(
                "SYSCALL",
                format: allConstSubtype,
                constants: ["const": 0xc],
                executor:
                {
                    (mips: Core) in
                    let core = mips as! MIPSCore
                    core.state = .environmentCall
                    
                }               
            )
        )

        //Halt and Spontaneously Combust. Not actually a part of MIPS.
        instructions.append(Instruction(
            "HSC",
            format: allConstSubtype,
            constants: ["const": 0x7f820000],
            executor:
            {
                (mips: Core) in
                let core = mips as! MIPSCore
                core.state = .error
                throw CoreError.cpuCaughtFire
            }
        ))
        
        //I-Type
        formats.append(
            Format(
                ranges:
                [
                    BitRange("opcode", at: 26, bits: 6),
                    BitRange("rs", at: 21, bits: 5, parameter: 1, parameterType: .register),
                    BitRange("rt", at: 16, bits: 5, parameter: 0, parameterType: .register),
                    BitRange("imm", at: 0, bits: 16, parameter: 2, parameterType: .immediate)
                ],
                regex: Regex("[a-zA-Z]+\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(\\$[A-Za-z0-9]+)\\s*,\\s*(-?[a-zA-Z0-9_]+)/")!,
                disassembly: "@mnem @arg0, @arg1, @arg2"
            )
        )

        guard let iType = formats.last
        else
        {
            return nil
        }
        
        //TO-DO: Finish MIPS.

        let abiNames = ["$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"]

        let keywords: [Keyword: [String]] = [
            .directive: ["\\."],
            .comment: ["#"],
            .label: ["\\:"],
            .stringMarker: ["\\\""],
            .charMarker: ["\\\'"],
            .register: ["\\$"]
        ]

        let directives: [String: Directive] = [
            "text": .text,
            "data": .data,
            "ascii": .string,
            "asciiz": .cString,
            "byte": ._8bit,
            "half": ._16bit,
            "word": ._32bit
        ]
       
        return InstructionSet(bits: 32, formats: formats, instructions: instructions, abiNames: abiNames, keywords: keywords, directives: directives)
    }
    
    static let MIPS = Oak_gen_MIPS()
}

public class MIPSRegisterFile
{
    private var memorySize: Int
    private var file: [UInt32]

    public var count: Int = 32

    subscript(index: Int) -> UInt32
    {
        get
        {
            if index == 0 || index > 31
            {
                return 0
            }
            return file[index - 1]
        }
        set {
            if index == 0 || index > 31
            {
                return
            }
            file[index - 1] = newValue
        }
    }

    func reset()
    {
        for i in 0...30
        {
           file[i] = 0
        }
        self[29] = UInt32(self.memorySize)
    }

    init(memorySize: Int)
    {
        self.file = [UInt32](repeating: 0, count: 31)
        self.memorySize = memorySize
        self[29] = UInt32(memorySize) //stack pointer
    }
}

public class MIPSCore: Core
{    
    //Endiantiy
    public var endianness = Endianness.little

    //Instruction Set
    public var instructionSet: InstructionSet

    //Registers
    public var registerFile: MIPSRegisterFile

    //Memory
    public var memory: Memory
    
    //Program Counter
    public var programCounter: UInt32

    //Fetched
    public var state: CoreState

    public func reset()
    {
        self.programCounter = 0
        self.registerFile.reset()
    }
    
    //Fetch...
    public var fetched: UInt
    public func fetch() throws
    {
        do
        {
            let bytes = try self.memory.copy(UInt(programCounter), count: 4)
            self.fetched = Utils.concatenate(bytes: bytes)
            programCounter += 4
        }
        catch
        {
            state = .error
            throw error
        }
    }
    
    //Decode...
    public var decoded: Instruction?
    public var rawValues = [UInt]()
    public var arguments = [UInt]()
    public var fields = [Int: String]()
    

    public func loadProgram(machineCode: [UInt8]) throws
    {
        if machineCode.count < memory.size
        {
            do
            {
                try memory.set(0, bytes: machineCode)
            }
            catch
            {
                throw error
            }
            state = .running
            return
        }
        throw MemoryError.illegalMemoryAccess
    }

    public func registerDump() -> String
    {
        var dump = ""
        for i in 0..<registerFile.count
        {
            dump += "$\(i) \(instructionSet.abiNames[i]) \(registerFile[i])\n"
        }
        return dump
    }

    public var service: [UInt]
    {
        return [UInt(registerFile[2]), UInt(registerFile[4]), UInt(registerFile[5]), UInt(registerFile[6]), UInt(registerFile[7])]
    }

    public var registers: [(abiName: String, value: UInt)]
    {
        var array = [(abiName: String, value: UInt)]()
        for i in 0...31
        {
            array.append((abiName: instructionSet.abiNames[i], value: UInt(registerFile[i])))
        }
        return array
    }

    public var pc: UInt
    {
        return UInt(programCounter &- 4)
    }

    public init?(memorySize: Int = 4096)
    {
        guard let MIPS = InstructionSet.MIPS
        else
        {
            return nil
        }
        self.programCounter = 0
        self.instructionSet = MIPS
        self.registerFile = MIPSRegisterFile(memorySize: memorySize)
        self.memory = SimpleMemory(memorySize)
        self.fetched = 0
        self.state = .idle
    }
}

