<template>
    <g>
        <line v-for="(line, i) in annotation_lines" :key="`l${i}}`"
              :x1="line.x1" :x2="line.x2" :y1="line.y1" :y2="line.y2"
              class="annotation" :stroke="line.color" :stroke-dasharray="line.dash">
        </line>
    </g>
</template>

<script>
export default {
    name: "Annotations",
    props: {
        annotations: {
            type: Array,
            default: function () {
                return []
            }
        },
        width: {
            type: Number
        },
        height: {
            type: Number
        },
        margin: {
            type: Object,
            required: true
        },
        linearScale: {
            type: Function
        },
        barScale: {
            type: Function
        },
        direction: {
            type: String,
            default: 'vertical'
        }
    },
    computed: {
        annotation_lines() {
            const yScale = this.direction === 'vertical' ? this.linearScale : this.barScale
            const xScale = this.direction === 'vertical' ? this.barScale : this.linearScale

            return this.annotations.filter(annotation => annotation.type === 'line').map(item => ({
                x1: item.axis === 'y' ? this.margin.left : xScale(item.value),
                x2: item.axis === 'y' ? this.width - this.margin.right : xScale(item.value),
                y1: item.axis === 'y' ? yScale(item.value) : this.margin.top,
                y2: item.axis === 'y' ? yScale(item.value) : this.height - this.margin.bottom,
                color: item.color ? item.color : 'black',
                dash: item.dash ? '5 5' : ''
            }))
        }
    }
}
</script>

<style scoped>
.annotation {
    stroke-width: 1;
}
</style>