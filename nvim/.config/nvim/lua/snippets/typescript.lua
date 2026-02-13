local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    ----------------
    -- Testing
    ----------------
    s('desc', {
        t("describe('"),
        i(1, 'Subject'),
        t({ "', () => {", '    ' }),
        i(2),
        t({ '', '});' }),
    }),

    s('it', {
        t("it('should "),
        i(1, 'do something'),
        t({ "', () => {", '    ' }),
        i(2),
        t({ '', '});' }),
    }),

    s('ita', {
        t("it('should "),
        i(1, 'do something'),
        t({ "', async () => {", '    ' }),
        i(2),
        t({ '', '});' }),
    }),

    s('bfe', {
        t({ 'beforeEach(() => {', '    ' }),
        i(1),
        t({ '', '});' }),
    }),

    s('afe', {
        t({ 'afterEach(() => {', '    ' }),
        i(1),
        t({ '', '});' }),
    }),

    s('exp', {
        t('expect('),
        i(1, 'actual'),
        t(').toBe('),
        i(2, 'expected'),
        t(');'),
    }),

    ----------------
    -- Angular 21+
    ----------------
    s('ngsig', {
        t('const '),
        i(1, 'name'),
        t(' = signal<'),
        i(2, 'Type'),
        t('>('),
        i(3, 'initialValue'),
        t(');'),
    }),

    s('ngcmp', {
        t('const '),
        i(1, 'name'),
        t({ ' = computed(() => ', '    ' }),
        i(2),
        t({ '', ');' }),
    }),

    s('ngeff', {
        t({ 'effect(() => {', '    ' }),
        i(1),
        t({ '', '});' }),
    }),

    s('nginj', {
        t('private readonly '),
        i(1, 'service'),
        t(' = inject('),
        i(2, 'Service'),
        t(');'),
    }),

    s('ngcomp', {
        t({ "@Component({", "    selector: 'app-" }),
        i(1, 'name'),
        t({ "',", "    standalone: true,", "    imports: [" }),
        i(2),
        t({ '],', "    template: `", '        ' }),
        i(3, '<p>works</p>'),
        t({ '', '    `,', '})', 'export class ' }),
        i(4, 'Name'),
        t({ 'Component {', '    ' }),
        i(5),
        t({ '', '}' }),
    }),

    ----------------
    -- TypeScript
    ----------------
    s('intf', {
        t('export interface '),
        i(1, 'Name'),
        t({ ' {', '    ' }),
        i(2),
        t({ '', '}' }),
    }),

    s('ttype', {
        t('export type '),
        i(1, 'Name'),
        t(' = '),
        i(2),
        t(';'),
    }),
}
