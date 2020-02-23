Vue.component('leaderboard', {
    template: `
<section id="leaderboard">
    <table cellspacing="0">
        <tr>
            <th>Rang</th>
            <th>Joueur</th>
            <th>Pépites</th>
        </tr>
        <tr v-for="entry in leaderboard">
            <td class="place"><div class="bubble">{{ entry.place }}</div></td>
            <td class="display-name">{{ entry.name }}</td>
            <td class="golden-nuggets">{{ entry.golden_nuggets }}</td>
        </tr>
    </table>
</section>
    `,
    data: () => {
        return {
            leaderboard: [
                {place: 1, name: 'Kanemzi', golden_nuggets: 125354},
                {place: 2, name: 'Iskrivv', golden_nuggets: 125235},
                {place: 3, name: 'EnkyuTV', golden_nuggets: 102215},
                {place: 4, name: 'Kanemzi', golden_nuggets: 50554},
                {place: 5, name: 'Iskrivv', golden_nuggets: 50222},
                {place: 6, name: 'EnkyuTV', golden_nuggets: 10221},
                {place: 7, name: 'Kanemzi', golden_nuggets: 10001},
                {place: 8, name: 'Iskrivv', golden_nuggets: 5051},
                {place: 9, name: 'EnkyuTV', golden_nuggets: 3211},
                {place: 10, name: 'Kanemzi', golden_nuggets: 3012}
            ]
        }
    }
  })