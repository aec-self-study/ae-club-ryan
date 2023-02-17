import random

denoms = list(range(10))

random.shuffle(denoms)

for i in range(10):
    print(f'i: {i}')
    x = denoms[i]
    print(f'x: {x}')
    result = 100 / x


for i in range(10):
    import pdb; pdb.set_trace()
    x = denoms[i]
    result = 100 / x