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
  sign        @3 (cleartext :Data, profile :SigningProfile) -> (signed :Data);
  public      @4 () -> (key :Key);

  enum SigningProfile {
    profileBlockchainEcdsaSha256 @0;
    profileBlockchainEcdsaSha512 @1;
    profileEcdsaNoHashm          @2;
  }
}

interface Keyring {
  new         @0 (label :Text, algo :KeygenAlgorithm) -> (key :Key);
  key         @1 (label :Text) -> (key :Key);
}
  