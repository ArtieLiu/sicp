def show(from_stick, to_stick, spare_stick):
    print('-------')
    print(f"from : {from_stick}")
    print(f"to   : {to_stick}")
    print(f"spare: {spare_stick}")


def move(plates, from_stick, to_stick, spare_stick):
    show(from_stick, to_stick, spare_stick)
    if plates == 0:
        print("done")
    else:
        move(plates=plates - 1,
             from_stick=from_stick,
             to_stick=spare_stick,
             spare_stick=to_stick)

        # move the most inner plate to spare stick
        flying_plate = from_stick.pop()
        to_stick.append(flying_plate)

        move(plates=plates - 1,
             from_stick=spare_stick,
             to_stick=to_stick,
             spare_stick=from_stick)


if __name__ == '__main__':
    from_stick = [5, 4, 3, 2, 1]
    to_stick = []
    spare_stick = []
    move(len(from_stick), from_stick, to_stick, spare_stick)
