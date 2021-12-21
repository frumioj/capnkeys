@0x95f5e5f118ac23a4;

# required golang-specific annotations
using Go = import "/go.capnp";
$Go.package("keys");
$Go.import("github.com/regen-network/keys");

enum KeygenAlgorithm {
  keygenSecp256k1 @0;
  keygenSecp256r1 @1;
}

interface Key {
  label       @0 () -> (label :Text);
  size        @1 () -> (size  :UInt64);
  keygenAlgo  @2 () -> (algo  :KeygenAlgorithm);
  sign        @3 (cleartext :Signable, profile :SigningProfile) -> (signed :Data);
  public      @4 () -> (key :Key);

  struct Signable {
    
# sign the hash of the proposal (so hash of already-signed proposal is
# sent in this message)?
    
    data :union {
      text        @0 :Data;
      transaction @1 :Transaction;
    }
  }
  
  enum SigningProfile {
    profileBlockchainEcdsaSha256 @0;
    profileBlockchainEcdsaSha512 @1;
    profileEcdsaNoHashm          @2;
  }
}

interface Keyring {
  newKey      @0 (label :Text, algo :KeygenAlgorithm) -> (key :Key);
  key         @1 (label :Text) -> (key :Key);
  owner       @2 () -> (owner :Data);
}

interface Transaction {
  txBody      @0 () -> (txBody :Data);
  authInfo    @1 () -> (authInfo :Data);
  signatues   @2 () -> (sigs :List(Data));
}
