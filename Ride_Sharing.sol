pragma solidity 0.4.26;

contract Authentication {
    uint256 public nbOfUsers;
    uint256 public nbOfDrivers;

    struct User {
        string first_name;
        string last_name;
        string email;
        string username;
        string phone_number;
        string password;
        address userAddress;
    }
    
    struct Driver {
        string driver_name;
        string vehical_name;
        string vehical_number;
        string username;
        string phone_number;
        string password;
        address driverAddress;
    }

    mapping(address => User) private user;
    mapping(address => Driver) private driver;

    constructor() public {
        nbOfUsers = 0;
        nbOfDrivers =0;
    }

    function register(string memory _first_name,string memory _last_name,string memory _email,string memory _username,string memory _phone_number,string memory _password) public {
        require(
            user[msg.sender].userAddress ==
                address(0x0000000000000000000000000000000000000000),
            "already registered"
        );

        user[msg.sender].first_name = _first_name;
        user[msg.sender].last_name = _last_name;
        user[msg.sender].email = _email;
        user[msg.sender].username = _username;
        user[msg.sender].phone_number= _phone_number;
        user[msg.sender].password = _password;
        user[msg.sender].userAddress = msg.sender;
        nbOfUsers++;
    }
    
    function login(string memory _phone_number,string memory _password) public view returns (string memory,string memory,string memory,string memory,string memory,string memory) {
        require(msg.sender == user[msg.sender].userAddress, "Not allowed");
        
        if ((bytes(_phone_number).length == bytes(user[msg.sender].phone_number).length) && (bytes(_password).length == bytes(user[msg.sender].password).length))
        {
            return (user[msg.sender].username, user[msg.sender].first_name, user[msg.sender].last_name, user[msg.sender].phone_number, user[msg.sender].email, user[msg.sender].password);
        }
    }
    
    function driverRegister(string memory _driver_name,string memory _vehical_name,string memory _vehical_number,string memory _username,string memory _phone_number,string memory _password) public {
        require(
            driver[msg.sender].driverAddress ==
                address(0x0000000000000000000000000000000000000000),
            "already registered"
        );

        driver[msg.sender].driver_name = _driver_name;
        driver[msg.sender].vehical_name = _vehical_name;
        driver[msg.sender].vehical_number = _vehical_number;
        driver[msg.sender].username = _username;
        driver[msg.sender].phone_number= _phone_number;
        driver[msg.sender].password = _password;
        driver[msg.sender].driverAddress = msg.sender;
        nbOfDrivers++;
    }
    
    function driverLogin(string memory _phone_number,string memory _password) public view returns (string memory,string memory,string memory,string memory,string memory,string memory) {
        require(msg.sender == driver[msg.sender].driverAddress, "Not allowed");
        
        if ((bytes(_phone_number).length == bytes(driver[msg.sender].phone_number).length) && (bytes(_password).length == bytes(driver[msg.sender].password).length))
        {
            return (driver[msg.sender].username, driver[msg.sender].driver_name, driver[msg.sender].vehical_name, driver[msg.sender].vehical_number, driver[msg.sender].phone_number, driver[msg.sender].password);
        }
    }
    
    function getUserAddress() public view returns (address) {
        return user[msg.sender].userAddress;
    }
}
