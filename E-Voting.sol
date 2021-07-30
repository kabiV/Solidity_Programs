pragma solidity 0.4.26;

contract Election {
    uint256 public nbOfVoters;
    
    struct Voter {
        string first_name;
        string last_name;
        string email;
        string username;
        string phone_number;
        string password;
        address userAddress;
        
        bool voted;
        uint voterIndex;
        uint weigth;
    }
    
    struct Canditate {
        string name;
        uint voteCount;
    }
    
    struct Admin {
        string username;
        string password;
    }
    
    address public owner;
    string public name;
    mapping(address => Voter) private voters;
    mapping(address => Admin) private admin;
    Canditate[] public canditates;
    uint public auctionEnd;
    
    event ElectionResult(string name, uint voteCount);
    
    constructor(string _name, uint duraitonMinutes, string canditate1, string canditate2, string canditate3) public {
        owner = msg.sender;
        nbOfVoters = 0;
        
        admin[msg.sender].username = "admin";
        admin[msg.sender].password = "admin";
        
        canditates.push(Canditate(canditate1, 0));
        canditates.push(Canditate(canditate2, 0));
        canditates.push(Canditate(canditate3, 0));
        name = _name;
        auctionEnd = now + (duraitonMinutes *1 minutes);
    }
    
    function register(string memory _first_name,string memory _last_name,string memory _email,string memory _username,string memory _phone_number,string memory _password) public returns(address) {
        require(
            voters[msg.sender].userAddress ==
                address(0x0000000000000000000000000000000000000000),
            "already registered"
        );

        voters[msg.sender].first_name = _first_name;
        voters[msg.sender].last_name = _last_name;
        voters[msg.sender].email = _email;
        voters[msg.sender].username = _username;
        voters[msg.sender].phone_number= _phone_number;
        voters[msg.sender].password = _password;
        voters[msg.sender].userAddress = msg.sender;
        nbOfVoters++;
        return (voters[msg.sender].userAddress);
    }
    
    function login(string memory _phone_number,string memory _password) public view returns (string memory,string memory,string memory,string memory,string memory,string memory) {
        require(msg.sender == voters[msg.sender].userAddress, "Not allowed");
        
        if ((bytes(_phone_number).length == bytes(voters[msg.sender].phone_number).length) && (bytes(_password).length == bytes(voters[msg.sender].password).length))
        {
            return (voters[msg.sender].username, voters[msg.sender].first_name, voters[msg.sender].last_name, voters[msg.sender].phone_number, voters[msg.sender].email, voters[msg.sender].password);
        }
    }
    
    function getInfo() public view returns (string memory,string memory,string memory,string memory,string memory,string memory) {
        require(msg.sender == owner);
        return (voters[msg.sender].username, voters[msg.sender].first_name, voters[msg.sender].last_name, voters[msg.sender].phone_number, voters[msg.sender].email, voters[msg.sender].password);
    }
    
    function authorize(address voter) public {
        require(msg.sender == owner);
        require(!voters[voter].voted);
        voters[voter].weigth = 1;
    }
    
    function vote(uint voterIndex) public {
        require (now < auctionEnd);
        require (!voters[msg.sender].voted);
        
        voters[msg.sender].voted = true;
        voters[msg.sender].voterIndex = voterIndex;
        
        canditates[voterIndex].voteCount += voters[msg.sender].weigth;
    }
    
    function end() public {
        
        require (msg.sender == owner);
        require (now <= auctionEnd);
        
        for (uint i=0; i < canditates.length; i++) {
            emit ElectionResult(canditates[i].name, canditates[i].voteCount);
        }
    }
    
}
