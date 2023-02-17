## loop using while instead of conditional formatting
x = 10

while x > 0:
    print('X is equal to '+str(x))
    x = x-1

## loop that loops over keys in a dictionary and prints the values
mlb_team_wins = {'Yankees':100,'Cardinals':93,'Mets':50,'Boston':80,'Royals':60, }

for x in mlb_team_wins.keys():
    print(mlb_team_wins[x])


## write the function is_even and is_odd from the lecture
def is_even(x):
    if x%2==0:
        return True
    else:
        return False

def is_odd(x):
    if x%2==0:
        return False
    else:
        return True

is_even(39)


## loop over my_first_list and create logic

my_first_list = ['apple',1,'banana',2]
cal_lookup={'apple':95, 'banana':105, 'orange':45}

for x in my_first_list:
    if type(x) == int:
        x=x**2
        print(x)
    else:
        print(cal_lookup[x])


## write a function for the following directions in the lesson

def test_function(dict):
    for x in dict.keys():
        print(dict[x]**2)

test_function(cal_lookup)