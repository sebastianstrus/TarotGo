#!/bin/bash

# Verify all 78 tarot cards are present
# Run from TarotGo project directory

CARDS_DIR="TarotGo/Assets.xcassets/TarotCards"

echo "🔍 Verifying Tarot Cards..."
echo "================================"

# Expected cards list
EXPECTED_CARDS=(
    # Major Arcana (22)
    "the_fool"
    "the_magician"
    "the_high_priestess"
    "the_empress"
    "the_emperor"
    "the_hierophant"
    "the_lovers"
    "the_chariot"
    "strength"
    "the_hermit"
    "wheel_of_fortune"
    "justice"
    "the_hanged_man"
    "death"
    "temperance"
    "the_devil"
    "the_tower"
    "the_star"
    "the_moon"
    "the_sun"
    "judgement"
    "the_world"

    # Cups (14)
    "ace_of_cups"
    "two_of_cups"
    "three_of_cups"
    "four_of_cups"
    "five_of_cups"
    "six_of_cups"
    "seven_of_cups"
    "eight_of_cups"
    "nine_of_cups"
    "ten_of_cups"
    "page_of_cups"
    "knight_of_cups"
    "queen_of_cups"
    "king_of_cups"

    # Pentacles (14)
    "ace_of_pentacles"
    "two_of_pentacles"
    "three_of_pentacles"
    "four_of_pentacles"
    "five_of_pentacles"
    "six_of_pentacles"
    "seven_of_pentacles"
    "eight_of_pentacles"
    "nine_of_pentacles"
    "ten_of_pentacles"
    "page_of_pentacles"
    "knight_of_pentacles"
    "queen_of_pentacles"
    "king_of_pentacles"

    # Swords (14)
    "ace_of_swords"
    "two_of_swords"
    "three_of_swords"
    "four_of_swords"
    "five_of_swords"
    "six_of_swords"
    "seven_of_swords"
    "eight_of_swords"
    "nine_of_swords"
    "ten_of_swords"
    "page_of_swords"
    "knight_of_swords"
    "queen_of_swords"
    "king_of_swords"

    # Wands (14)
    "ace_of_wands"
    "two_of_wands"
    "three_of_wands"
    "four_of_wands"
    "five_of_wands"
    "six_of_wands"
    "seven_of_wands"
    "eight_of_wands"
    "nine_of_wands"
    "ten_of_wands"
    "page_of_wands"
    "knight_of_wands"
    "queen_of_wands"
    "king_of_wands"
)

MISSING_CARDS=()
WRONG_SIZE_CARDS=()
TOTAL=0
FOUND=0

for card in "${EXPECTED_CARDS[@]}"; do
    TOTAL=$((TOTAL + 1))
    IMAGESET_DIR="$CARDS_DIR/${card}.imageset"
    IMAGE_FILE="$IMAGESET_DIR/${card}.png"

    if [ -d "$IMAGESET_DIR" ]; then
        if [ -f "$IMAGE_FILE" ]; then
            FOUND=$((FOUND + 1))

            # Check dimensions
            DIMENSIONS=$(sips -g pixelWidth -g pixelHeight "$IMAGE_FILE" 2>/dev/null)
            WIDTH=$(echo "$DIMENSIONS" | grep "pixelWidth:" | awk '{print $2}')
            HEIGHT=$(echo "$DIMENSIONS" | grep "pixelHeight:" | awk '{print $2}')

            if [ "$WIDTH" != "1108" ] || [ "$HEIGHT" != "1900" ]; then
                WRONG_SIZE_CARDS+=("$card (${WIDTH}x${HEIGHT})")
            fi
        else
            MISSING_CARDS+=("$card (imageset exists but no PNG file)")
        fi
    else
        MISSING_CARDS+=("$card (no imageset)")
    fi
done

echo ""
echo "📊 Results:"
echo "  Total expected: $TOTAL"
echo "  Found: $FOUND"
echo "  Missing: ${#MISSING_CARDS[@]}"
echo "  Wrong size: ${#WRONG_SIZE_CARDS[@]}"
echo ""

if [ ${#MISSING_CARDS[@]} -gt 0 ]; then
    echo "❌ Missing cards:"
    for card in "${MISSING_CARDS[@]}"; do
        echo "  - $card"
    done
    echo ""
fi

if [ ${#WRONG_SIZE_CARDS[@]} -gt 0 ]; then
    echo "⚠️  Cards with wrong dimensions (expected 1108x1900):"
    for card in "${WRONG_SIZE_CARDS[@]}"; do
        echo "  - $card"
    done
    echo ""
fi

if [ ${#MISSING_CARDS[@]} -eq 0 ] && [ ${#WRONG_SIZE_CARDS[@]} -eq 0 ]; then
    echo "✅ All 78 cards are present with correct dimensions!"
    exit 0
else
    echo "❌ Verification failed!"
    exit 1
fi
