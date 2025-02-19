from mlir_xten.ir import Module, Context, StringAttr
from mlir_xten.dialects import xten_nn

with Context() as ctx:
    xten_nn.register_dialect(ctx)
    test_path = 'resnet18_L1.mlir'
    module = Module.parse(open(test_path).read(), ctx)
    print(module)
    print("\n---------------------------\n")
    count = 0 
    # Count number of InCoreChains
    for layer in module.body.operations[0].regions[0].blocks[0].operations:
        if (isinstance(layer, xten_nn.SubgraphOp)
            and StringAttr(layer.attributes["Reason"]).value == "InCoreChain"):
            count = count + 1 
    
    print("Number of InCoreChains = ", count) 
    assert(count == 3)