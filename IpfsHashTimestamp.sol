 /**
 *Submitted for verification at Etherscan.io on 2020-12-24
*/

pragma solidity >=0.5.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
**/
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

  /**
   * @dev Main smart contract is below which takes a hash and returns the blockTime the hash
   on ethereum was performed. More info in the readme.md file included.
   */
contract simpleStorage is Ownable {
    
    uint256 public hashCount;
    
    struct Store {
        uint hashIndex;
        bytes32 docHash;
        uint storingTime;
    }
    
    mapping(uint => Store) public store;
    event AddDocument(uint _index, bytes32 _hash, uint _time);
    
    function addDocument(bytes32 _hash) onlyOwner external returns(uint256) {
        uint256 blockTime = now;
        
        store[hashCount].hashIndex = hashCount;
        store[hashCount].docHash = _hash;
        store[hashCount].storingTime = blockTime;
        
        emit AddDocument(hashCount, _hash, blockTime);
        hashCount++;
        
        return blockTime;
    } 
    
}
