// DevOps:	https://www.techtarget.com/searchitoperations/tip/How-to-start-DevOps-A-step-by-step-guide
// const contractAddress = "0x954D9595fC559550A3d86451d8e23b109b44798A";
/*
FYI
My account address:  	0x87B64804e36f20acA9052D3b4Cd7188D41b59f97

RealEstate: Operator:	0x6454D367AD0969f4896c124Da4F45cedABA666De
	LandsSTORAGE:	0xE9283C05eEc53f46056Dd38307e4FB407efDf300	
	LandsAGENT:		0x9522B8a672bae13F717d135c878f5D25F7469a73

	PermitsStorage:	0xA1CF47402140D1c307434d74c7502B88B51a35DA
	PermitsAgent:	0x741882309D089AD619402446e68b0f064adBEE3D

	BuildingsStorage:	0xdB94F0b47bBEE83460A1e1B9B67f4d7b35CE0784
	BuildingsAgent:	0x7A522a78877Aa07bB2f6fF16706bed2168Bd684f

Token:
		STORAGE:	0x1f00309D2b1Aceb4F27CF47568F4E757B3d9e0db
		AGENT:	0x639338FE022a26C0590C0BC94d03d1A8828cE04a
main:
		Logic:	0x573DE6394Cd8334718FaDbEE95BA068F22b2cA13
		Proxy:	0x2C2a7Af491Ca58cEFD9069B4aD6270fe1B30682F


Logic.(constructor)


*/
const contractAddress = "0x2C2a7Af491Ca58cEFD9069B4aD6270fe1B30682F";


var ABI = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "_paused",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "alphaCall",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address[]",
				"name": "to",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "value",
				"type": "uint256[]"
			}
		],
		"name": "batchTransfer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "bravoCall",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "charlieCall",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "deltaCall",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "faucet",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestAddressValue",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestStringValue",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestUint256Value",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLogicAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMyBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSecretary",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSelfAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string[]",
				"name": "strings",
				"type": "string[]"
			}
		],
		"name": "setLatestStringValue",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256[]",
				"name": "uints",
				"type": "uint256[]"
			}
		],
		"name": "setLatestUint256Value",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "adr",
				"type": "address"
			}
		],
		"name": "setLogicAddress",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "setLogicsProxyAddress",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "adr",
				"type": "address"
			}
		],
		"name": "setSecretary",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transferFast",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]