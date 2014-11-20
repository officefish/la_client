package com.ps.cards.eptitude
{
	/**
	 * ...
	 * @author 
	 */
	public class EptitudePeriod 
	{
        public static const ACTIVATED:int = -1;

        public static const START_STEP:int = 0;
		public static const END_STEP:int = 1;

        public static const SELF_PLACED:int = 2;
        public static const ASSOCIATE_PLACED:int = 3;
        public static const OPPONENT_PLACED:int = 4;
        public static const ALL_PLACED:int = 5;

        public static const ASSOCIATE_RACE_PLACED:int = 6;
        public static const OPPONENT_RACE_PLACED:int = 7;
        public static const ALL_RACE_PLACED:int = 8;

        public static const SELF_WOUND:int = 9;
        public static const ASSOCIATE_WOUND:int = 10;
        public static const OPPONENT_WOUND:int = 11;
        public static const ALL_WOUND:int = 12;

        public static const SELF_DIE:int = 13;
        public static const ASSOCIATE_DIE:int = 14;
        public static const OPPONENT_DIE:int = 15;
        public static const ALL_DIE:int = 16;

        public static const ASSOCIATE_TREATED:int = 17;
        public static const OPPONENT_TREATED:int = 18;
        public static const ALL_TREATED:int = 19;

        public static const ASSOCIATE_SPELL:int = 20;
        public static const OPPONENT_SPELL:int = 21;
        public static const ALL_SPELL:int = 22;

        public static const ASSOCIATE_PLAY_CARD:int = 23;
        public static const OPPONENT_PLAY_CARD:int = 24;
        public static const ALL_PLAY_CARD:int = 25;

        public static const ATTACK:int = 26;

        public static const DESCRIPTION:Array =
                [
                    'Start step',
                    'End step',
                    'Self placed',
                    'Associate Placed',
                    'Opponent placed',
                    'All placed',
                    'Associate race placed',
                    'Opponent race placed',
                    'All race placed',
                    'Self Wound',
                    'Associate wound',
                    'Opponent wound',
                    'All wound',
                    'Self die',
                    'Associate die',
                    'Opponent die',
                    'All die',
                    'Associate treated',
                    'Opponent treated',
                    'All treated',
                    'Associate spell',
                    'Opponent spell',
                    'All Spell',
                    'Attack'
                 ]
		
	}



}